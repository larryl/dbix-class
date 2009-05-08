package # hide from PAUSE
  DBIx::Class::Storage::DBI::Replicated::Types;

=head1 NAME

DBIx::Class::Storage::DBI::Replicated::Types - Types used internally by
L<DBIx::Class::Storage::DBI::Replicated>

=cut

use MooseX::Types
  -declare => [qw/BalancerClassNamePart/];
use MooseX::Types::Moose qw/ClassName Str/;

class_type 'DBIx::Class::Storage::DBI';
class_type 'DBIx::Class::Schema';

subtype BalancerClassNamePart,
  as ClassName;
    
coerce BalancerClassNamePart,
  from Str,
  via {
    my $type = $_;
    if($type=~m/^::/) {
      $type = 'DBIx::Class::Storage::DBI::Replicated::Balancer'.$type;
    }  
    Class::MOP::load_class($type);  
    $type;  	
  };

=head1 AUTHOR

  John Napiorkowski <john.napiorkowski@takkle.com>

=head1 LICENSE

You may distribute this code under the same terms as Perl itself.

=cut

1;
