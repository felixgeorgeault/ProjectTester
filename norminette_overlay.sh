#!/bin/bash

# Définition des codes de couleur

RED_UNDERLINE='\033[4;31m'		# Rouge_underline
RED='\033[0;31m'				# Rouge
RED_HIGH='\e[0;101m'			# Rouge_High_back
GREEN='\033[0;32m'				# Vert
GREEN_HIGH='\e[0;102m'			# Vert_high_back
YELLOW='\033[0;33m'				# Jaune
YELLOW_HIGH='\e[0;103m'			# Jaune_high
PURPLE='\033[0;35m'				# Mauve
CYAN='\033[0;36m'				# Cyan
BLUE='\033[0;34m'				# Bleu
BLUE_HIGH='\e[0;104m'			# blue_high
BOLD='\033[1m'					# Gras
GREY_BLUE='\x1b[38;5;58m'		# bleu-gris
RESET='\033[0m'					# Réinitialisation des couleurs
PINK_HIGH='\x1b[48;5;205m'		# pink
RED_PURPLE='\x1b[38;5;126m'		# Red-Purple
PURPLE_HIGH='\e[0;105m'			# purple high
WHITE_HIGH='\x1b[48;5;255m'		# White high
BROWN='\x1b[48;5;95m'			# Brun

# Variables pour stocker les couleurs associées à chaque type d'erreur
INVALID_HEADER_COLOR="${RED_UNDERLINE}"

# Definition des variables de couleur par type

# Erreur d'indentation

SPACE_BEFORE_FUNC_COLOR="${CYAN}"
SPACE_AFTER_KW="${CYAN}"
SPC_BFR_PAR="${CYAN}"
SPACE_REPLACE_TAB_COLOR="${CYAN}"
SPACE_EMPTY_LINE_COLOR="${CYAN}"
CONSECUTIVE_SPC_COLOR="${CYAN}"
SPC_BEFORE_NL="${CYAN}"
SPC_BFR_OPERATOR="${CYAN}"
MIXED_SPACE_TAB="${CYAN}"
NO_SPC_BFR_OPR="${CYAN}"
SPC_AFTER_POINTER="${CYAN}"
TAB_INSTEAD_SPC="${CYAN}"
TOO_MANY_TAB="${CYAN}"
MISALIGNED_FUNC_DECL="${CYAN}"
CONSECUTIVE_NEWLINES="${CYAN}"
BRACE_NEWLINE="${CYAN}"
EXP_NEWLINE="${CYAN}"
TAB_REPLACE_SPACE="${CYAN}"
SPC_AFTER_PAR="${CYAN}"
EXP_PARENTHESIS="${CYAN}"
NO_SPC_BFR_PAR="${CYAN}"
NO_SPC_AFR_PAR="${CYAN}"
RETURN_PARENTHESIS="${CYAN}"
BRACE_SHOULD_EOL_COLOR="${CYAN}"
TOO_FEW_TAB="${CYAN}"
EOL_OPERATOR="${CYAN}"
SPC_AFTER_OPERATOR="${CYAN}"

# Erreur d'indentation de variable

NL_AFTER_VAR_DECL="${YELLOW}"
MISALIGNED_VAR_DECL_COLOR="${YELLOW}"
VAR_DECL_START_FUNC_COLOR="${YELLOW}"
DECL_ASSIGN_LINE_COLOR="${YELLOW}"
WRONG_SCOPE_VAR="${YELLOW}"
TOO_MANY_VARS_FUNC="${YELLOW_HIGH}"
ASSIGN_IN_CONTROL="${YELLOW}"
MULT_DECL_LINE="${YELLOW}"

# Erreur d'indentation en millieux de fonction

WRONG_SCOPE_COMMENT_COLOR="${PURPLE}"
EMPTY_LINE_FUNCTION_COLOR="${PURPLE}"

# Erreur d'indentation d'une ligne trop longue

LINE_TOO_LONG="${GREEN_HIGH}"

# Erreur d'indentation de fonction

TOO_MANY_LINES="${RED_HIGH}"
TOO_MANY_FUNCS="${RED_HIGH}"

# Erreur d'indentation de structure de controle

TERNARY_FBIDDEN="${BLUE_HIGH}"
FORBIDDEN_CS="${BLUE_HIGH}"
LABEL_FBIDDEN="${BLUE_HIGH}"
FORBIDDEN_CHAR_NAME="${RED_PURPLE}"

# Erreur d'indentation d'argument de fonction

TOO_MANY_ARGS="${PINK_HIGH}"
TOO_MANY_INSTR="${PINK_HIGH}"
TOO_MANY_VALS="${PINK_HIGH}"
NO_ARGS_VOID="${PINK_HIGH}"

# Erreur d'indentation spéciales

PREPROC_BAD_INDENT="${PURPLE_HIGH}"
GLOBAL_VAR_NAMING="${PURPLE_HIGH}"
GLOBAL_VAR_DETECTED="${PURPLE_HIGH}"
MISSING_TYPEDEF_ID="${PURPLE_HIGH}"

# Nom de fichier

FILE_NAME="${WHITE_HIGH}"

# Fonction pour mettre en forme une erreurr (carlos a rajouter un r (carlos le s ou le R ;})+lgbtaqia+ / 2 = PARAPLUIE
format_error() {
  local error="$1"

  # Extraire les informations de l'erreur
  local line="$(echo "$error" | awk -F'[()]' '{print $2}')"
  local col="$(echo "$error" | awk -F'[()]' '{print $4}')"
  local type="$(echo "$error" | awk '{print $2}')"
  local message="$(echo "$error" | awk -F':[[:blank:]]+' '{print $2}')"

  # Récupérer la couleur appropriée pour le type d'erreur
  local color="${RESET}"

  case "$type" in
    "TOO_MANY_TAB")    		   color="${TOO_MANY_TAB}"   	 			;;
    "TOO_MANY_TAB")    		   color="${TOO_MANY_TAB}"   	 			;;
	"NO_SPC_BFR_OPR")    	   color="${NO_SPC_BFR_OPR}"    			;;
	"SPC_AFTER_PAR")    	   color="${SPC_AFTER_PAR}"    				;;
	"GLOBAL_VAR_DETECTED")     color="${GLOBAL_VAR_DETECTED}"    		;;
	"GLOBAL_VAR_NAMING")   	   color="${GLOBAL_VAR_NAMING}"    	 	 	;;
	"NO_SPC_BFR_PAR")   	   color="${NO_SPC_BFR_PAR}"    	 	 	;;
	"MISALIGNED_FUNC_DECL")    color="${MISALIGNED_FUNC_DECL}"    	  	;;
	"MIXED_SPACE_TAB")  	   color="${MIXED_SPACE_TAB}"    	 	 	;;
	"EXP_NEWLINE")  	 	   color="${EXP_NEWLINE}"    	 		 	;;
	"SPC_AFTER_OPERATOR")  	   color="${SPC_AFTER_OPERATOR}"    	  	;;
	"MISSING_TYPEDEF_ID")  	   color="${MISSING_TYPEDEF_ID}"    	  	;;
	"TAB_REPLACE_SPACE")  	   color="${TAB_REPLACE_SPACE}"    	     	;;
	"MULT_DECL_LINE")  	  	   color="${MULT_DECL_LINE}"       			;;
	"TOO_MANY_VALS")  	  	   color="${TOO_MANY_VALS}"        			;;
	"PREPROC_BAD_INDENT")  	   color="${PREPROC_BAD_INDENT}"        	;;
    "BRACE_NEWLINE")  		   color="${BRACE_NEWLINE}"        			;;
    "CONSECUTIVE_NEWLINES")    color="${CONSECUTIVE_NEWLINES}"        	;;
    "TOO_MANY_FUNCS")          color="${TOO_MANY_FUNCS}"        	   	;;
    "EOL_OPERATOR")       	   color="${EOL_OPERATOR}"        	    	;;
    "SPC_BFR_OPERATOR")        color="${SPC_BFR_OPERATOR}"        		;;
    "TAB_INSTEAD_SPC")         color="${TAB_INSTEAD_SPC}"        		;;
    "NO_ARGS_VOID")       	   color="${NO_ARGS_VOID}"       	 		;;
    "INVALID_HEADER")          color="${INVALID_HEADER_COLOR}"          ;;
    "SPACE_BEFORE_FUNC")       color="${SPACE_BEFORE_FUNC_COLOR}"       ;;
    "SPACE_REPLACE_TAB")       color="${SPACE_REPLACE_TAB_COLOR}"       ;;
    "SPACE_EMPTY_LINE")        color="${SPACE_EMPTY_LINE_COLOR}"        ;;
    "MISALIGNED_VAR_DECL")     color="${MISALIGNED_VAR_DECL_COLOR}"     ;;
    "CONSECUTIVE_SPC")         color="${CONSECUTIVE_SPC_COLOR}"         ;;
    "WRONG_SCOPE_COMMENT")     color="${WRONG_SCOPE_COMMENT_COLOR}"     ;;
    "BRACE_SHOULD_EOL")        color="${BRACE_SHOULD_EOL_COLOR}"        ;;
    "EMPTY_LINE_FUNCTION")     color="${EMPTY_LINE_FUNCTION_COLOR}"     ;;
    "VAR_DECL_START_FUNC")     color="${VAR_DECL_START_FUNC_COLOR}"     ;;
    "DECL_ASSIGN_LINE")        color="${DECL_ASSIGN_LINE_COLOR}"        ;;
    "LINE_TOO_LONG")           color="${LINE_TOO_LONG}"                 ;;
    "TOO_MANY_LINES")          color="${TOO_MANY_LINES}"                ;;
    "SPACE_AFTER_KW")          color="${SPACE_AFTER_KW}"                ;;
    "SPC_BFR_PAR")             color="${SPC_BFR_PAR}"                   ;;
    "NL_AFTER_VAR_DECL")       color="${NL_AFTER_VAR_DECL}"             ;;
    "TOO_MANY_VARS_FUNC")      color="${TOO_MANY_VARS_FUNC}"            ;;
    "WRONG_SCOPE_VAR")         color="${WRONG_SCOPE_VAR}"               ;;
    "ASSIGN_IN_CONTROL")       color="${ASSIGN_IN_CONTROL}"             ;;
    "EXP_PARENTHESIS")         color="${EXP_PARENTHESIS}"               ;;
    "RETURN_PARENTHESIS")      color="${RETURN_PARENTHESIS}"            ;;
    "TOO_FEW_TAB")             color="${TOO_FEW_TAB}"                   ;;
    "TERNARY_FBIDDEN")         color="${TERNARY_FBIDDEN}"               ;;
    "FORBIDDEN_CS")            color="${FORBIDDEN_CS}"                  ;;
    "TOO_MANY_ARGS")           color="${TOO_MANY_ARGS}"                 ;;
    "SPC_AFTER_POINTER")       color="${SPC_AFTER_POINTER}"             ;;
    "TOO_MANY_INSTR")          color="${TOO_MANY_INSTR}"                ;;
    "NO_SPC_AFR_PAR")          color="${NO_SPC_AFR_PAR}"                ;;
    "FORBIDDEN_CHAR_NAME")     color="${FORBIDDEN_CHAR_NAME}"           ;;
    "SPC_BEFORE_NL")           color="${SPC_BEFORE_NL}"                 ;;
    "LABEL_FBIDDEN")           color="${LABEL_FBIDDEN}"                 ;;
  esac

  # Appliquer la couleur et la mise en forme appropriées en fonction du type d'erreur
    echo "$error" | grep -q ": Error!$"
	if [ $(echo $?) -eq 0 ]
		then
			color="${FILE_NAME}"
	fi
	printf "%b%s%b\n" "${color}${BOLD}" "$error" "${RESET}"
}

generate_report() {
  local norminette_output="$1"
  
  # Calcul des statistiques de qualité du code
  local total_errors=$(echo "$norminette_output" | wc -l)
  local error_counts=$(echo "$norminette_output" | awk '{print $2}' | sort | uniq -c)
  
  # Affichage du rapport
  echo ""
  echo "----- Quality Report -----"
  echo "Total Errors: $total_errors"
  echo "Error Counts:"
  echo "$error_counts"
}



options=""
norminette_arg=""
keyword_s_opt=""
keyword_i_opt=""
generate_report_opt=""

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -s)
      shift
      keyword_s_opt="$1"  # Stocke l'argument suivant dans la variable "keyword"
      shift
      ;;
    -i)
      shift
      keyword_i_opt="$1"  # Stocke l'argument suivant dans la variable "keyword"
      shift
      ;;
    -r)
      generate_report_opt="true"
      shift
      ;;
    -h)
      echo " -------------------------- HELP --------------------------- "
      echo "|                                                           |"
      echo "|                          DEFAULT                          |"
      echo "| usage : overlinette [FILE/DIRECTORY]                      |"
      echo "|                                                           |"
      echo "|                          OPTIONS                          |"
      echo "| -s : usage : overlinette -s [KEYWORD] [FILE/DIRECTORY]    |"
      echo "| -i : usage : overlinette -i [KEYWORD] [FILE/DIRECTORY]    |"
      echo "| -r : usage : overlinette -r [FILE/DIRECTORY]              |"
      echo "| -h : usage : overlinette -h                               |"
      echo "|                                                           |"
      echo " ----------------------------------------------------------- "
      shift
      ;;
    *)
      norminette_arg="$key"
      shift
      ;;
  esac
done

# Exécuter la commande norminette avec l'argument spécifié
if [ -n "$norminette_arg" ]; then
  norminette_output=$(norminette "$norminette_arg")
  if [ -n "$keyword_s_opt" ]; then
    norminette_output=$(echo "$norminette_output" | grep "$keyword_s_opt")
  fi

  if [ -n "$keyword_i_opt" ]; then
    norminette_output=$(echo "$norminette_output" | grep -v "$keyword_i_opt")
  fi

  echo "$norminette_output" | while IFS= read -r error; do
    format_error "$error"
  done
  
  if [ "$generate_report_opt" = "true" ]; then
    generate_report "$norminette_output"
  fi
fi