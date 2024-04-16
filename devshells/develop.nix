{
  perSystem = {
    config,
    system,
    pkgs,
    ...
  }: {
    devenv.shells.develop = {
      pre-commit = {
        hooks = {
          # actionlint.enable = true;
          alejandra.enable = true;
          # markdownlint.enable = true;
          # yamllint.enable = true;
        };

        settings = {
          markdownlint.config = {
            # party like it's not 1999
            MD013 = {
              line_length = 120;
              heading_line_length = 120;
              code_block_line_length = 120;
            };
          };
        };
      };
    };

    formatter = pkgs.alejandra;
  };
}
