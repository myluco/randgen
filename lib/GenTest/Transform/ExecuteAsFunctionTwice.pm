# Copyright (c) 2011 Oracle and/or its affiliates. All rights reserved.
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

package GenTest::Transform::ExecuteAsFunctionTwice;

require Exporter;
@ISA = qw(GenTest GenTest::Transform);

use strict;
use lib 'lib';

use GenTest;
use GenTest::Transform;
use GenTest::Constants;

sub transform {
	my ($class, $original_query, $executor, $original_result) = @_;

	return STATUS_WONT_HANDLE if $original_query !~ m{SELECT}io;
	return STATUS_WONT_HANDLE if $original_result->rows() != 1;
	return STATUS_WONT_HANDLE if $#{$original_result->data()->[0]} != 0;

	my $return_type = $original_result->columnTypes()->[0];
	$return_type .= "(255)" if $return_type =~ m{char}sgio;

	return [
		"DROP FUNCTION IF EXISTS stored_func_$$",
		"CREATE FUNCTION stored_func_$$ () RETURNS $return_type NOT DETERMINISTIC BEGIN DECLARE ret $return_type; $original_query INTO ret ; RETURN ret; END",
		"SELECT stored_func_$$() /* TRANSFORM_OUTCOME_UNORDERED_MATCH */",
                "SELECT stored_func_$$() /* TRANSFORM_OUTCOME_UNORDERED_MATCH */",
		"DROP FUNCTION IF EXISTS stored_func_$$"
	];
}

1;
