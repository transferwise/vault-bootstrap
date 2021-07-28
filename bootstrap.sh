#/bin/bash

[ -f $HOME/.vault ] && mv $HOME/.vault $HOME/.vault.bckp
[ -f $HOME/.token-helper.sh ] && rm $HOME/.token-helper.sh

printf "Creating token helper..\n"

tee -a ~/.token-helper.sh << END
#/bin/bash
case "\$1" in
  "get")
    [ -f $HOME/.vault-token ] && cat $HOME/.vault-token
    exit 0
    ;;
  "erase")
    rm $HOME/.vault-token
    exit 0
    ;;
  "store")
    read -r token
    printf "\$token" > $HOME/.vault-token
    exit 0
    ;;
  *)
    echo "Unknown method '\$1'."
    exit 1
    ;;
esac
END

chmod 744 $HOME/.token-helper.sh

printf "Creating vault config..\n"

tee -a ~/.vault << END
# ~/.vault
token_helper = "$HOME/.token-helper.sh"
END
