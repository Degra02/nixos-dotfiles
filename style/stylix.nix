{ lib, pkgs, stylix, user_settings, ... }:

let
  themePath = "../themes/"+user_settings.theme+"/"+user_settings.theme+".yaml";
  backgroundUrl = builtins.readFile (./. + "../themes"+("/"+user_settings.theme)+"/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../themes/"+("/"+user_settings.theme)+"/backgroundsha256.txt");
in
{
  imports = [ stylix.nixosModules.stylix ];

  stylix.autoEnable = false;
  stylix.image = pkgs.fetchurl {
   url = backgroundUrl;
   sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + themePath;
  stylix.fonts = {
    monospace = {
      name = user_settings.font;
      package = user_settings.fontPkg;
    };
    serif = {
      name = user_settings.font;
      package = user_settings.fontPkg;
    };
    sansSerif = {
      name = user_settings.font;
      package = user_settings.fontPkg;
    };
  };
}
