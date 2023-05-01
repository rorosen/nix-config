{ ... }:

{
  services.swaync = {
    enable = true;

    settings = {
      foo = "bar";
    };
    style = {
      bar = "baz";
    };
  };
}
