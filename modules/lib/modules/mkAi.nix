{lib, ...}: let
  inherit (lib) types mkOption mkEnableOption;

  # a utility helper to standerdize ai options.
  mkAi = {
    name,
    model ? "gpt-4-turbo",
    temperature ? 1,
    maxTokens ? null,
    before ? "",
    after ? "",
    extraOptions ? {}, # used to define additional modules
  }: {
    enable = mkEnableOption "${name} ai command";
    settings =
      {
        model = mkOption {
          type = types.enum [
            "gpt-4-turbo"
            "gpt-4o"
            "gpt-4o-mini"
          ];
          default = model;
          description = "The name of the dotenv file to load, or a list of dotenv files to load in order of precedence.";
        };

        temperature = mkOption {
          type = types.int;
          default = temperature;
          description = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.";
        };

        maxTokens = mkOption {
          type = types.nullOr types.int;
          default = maxTokens;
          description = "The maximum number of tokens that can be generated in the chat completion. The total length of input tokens and generated tokens is limited by the model's context length.";
        };

        systemMessage = {
          before = mkOption {
            type = types.str;
            default = before;
            description = "This will be inserted at the start of the system message";
          };
          after = mkOption {
            type = types.str;
            default = after;
            description = "This will be inserted at the end of the system message";
          };
        };
      }
      // extraOptions;
  };
in
  mkAi