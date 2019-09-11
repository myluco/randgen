# Copyright (c) 2008, 2012 Oracle and/or its affiliates. All rights reserved.
# Copyright (C) 2017 MariaDB Corporatin Ab
# Use is subject to license terms.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301
# USA

package GenTest::Transform::ExecuteAsIntersect;

require Exporter;
@ISA = qw(GenTest GenTest::Transform);

use strict;
use lib 'lib';

use GenTest;
use GenTest::Transform;
use GenTest::Constants;

sub transform {
	my ($class, $orig_query, $executor) = @_;
	
	# We skip: - [OUTFILE | INFILE] queries because these are not data producing and fail (STATUS_ENVIRONMENT_FAILURE)
	return STATUS_WONT_HANDLE if $orig_query =~ m{(OUTFILE|INFILE|PROCESSLIST|INTO)}sio
		|| $orig_query !~ m{^\s*SELECT}sio;

	my $orig_query_zero_limit = $orig_query;
	# We remove LIMIT/OFFSET if present in the (outer) query, because we are
	# using LIMIT 0 instead
	$orig_query_zero_limit =~ s{LIMIT\s+\d+(?:\s+OFFSET\s+\d+)?}{}gsio;
	$orig_query_zero_limit =~ s{(FOR\s+UPDATE|LOCK\s+IN\s+(?:SHARE|EXCLUSIVE)\sMODE)\s+LIMIT 0}{LIMIT 0 $1}sio;
    unless ($orig_query_zero_limit =~ /LIMIT\s+0/sio) {
        $orig_query_zero_limit.= ' LIMIT 0';
    }

	return [
		"( $orig_query ) INTERSECT ( $orig_query ) /* TRANSFORM_OUTCOME_DISTINCT */",
		"( $orig_query ) INTERSECT ( $orig_query_zero_limit ) /* TRANSFORM_OUTCOME_EMPTY_RESULT */"
	];
}

1;
