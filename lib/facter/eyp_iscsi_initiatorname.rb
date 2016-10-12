if File.exist?('/etc/iscsi/initiatorname.iscsi')
  initiatorname = Facter::Util::Resolution.exec('bash -c \'cat /etc/iscsi/initiatorname.iscsi  | cut -f 2 -d=\'').to_s

  unless initiatorname.nil? or initiatorname.empty?
    Facter.add('eyp_iscsi_initiatorname') do
        setcode do
          initiatorname
        end
    end
  end
end
