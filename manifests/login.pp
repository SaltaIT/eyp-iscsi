define iscsi::login() {

  #iscsiadm -m node -l

  # login to available targets iscsiadm -m node -L all
  # login to specific target iscsiadm -m node --targetname=<targetname> --login
  # logout: iscsiadm -m node -U all
}
