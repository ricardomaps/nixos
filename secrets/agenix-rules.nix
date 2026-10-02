let
  ricardomaps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMewo+6MUkWGa3E27ELpMv1QSvdgeq1d8ieNW2Uaj4KD";
in
{
  "password.age".publicKeys = [ ricardomaps ];
}
