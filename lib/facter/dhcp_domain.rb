require 'facter'

def dhcp_domain
  command = <<-SHELL
    cat /var/lib/dhcp/dhclient.* |
    grep "option domain-name " |
    tail -1 |
    cut -d '"' -f 2
  SHELL

  Facter::Util::Resolution.exec( command.strip )
end

Facter.add(:dhcp_domain) do
  confine :osfamily => 'Debian'
  setcode do
    dhcp_domain
  end
end
