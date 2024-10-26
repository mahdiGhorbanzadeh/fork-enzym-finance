
#!/bin/bash

# Define the available network options
networks=("amoy" "polygon")

# Define the available contract options
contracts=("AccessRestriction" "GameZeroBounty" "LaunchPad1155" "LandRocker" "TeamBonus")

# Function to prompt the user to choose an option from a list
choose() {
    prompt="$1"
    options=("${@:2}")

    printf "\n%s\n" "$prompt"
    for i in "${!options[@]}"; do
        printf "%d) %s\n" "$((i+1))" "${options[$i]}"
    done

    while true; do
        read -p "Enter your choice: " choice
        if [[ "$choice" -ge 1 && "$choice" -le "${#options[@]}" ]]; then
            echo "${options[$((choice-1))]}"
            return
        fi
        echo "Invalid choice, please try again."
    done
}

# Function to ask the user a yes/no question
ask() {
    prompt="$1"
    default="$2"

    while true; do
        read -p "$prompt [$default]: " response
        if [[ -z "$response" ]]; then
            response="$default"
        fi
        case "$response" in
            [Yy]* ) echo "yes"; return;;
            [Nn]* ) echo "no"; return;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Ask user for network
echo "${YELLOW}Available networks:"
for i in "${!networks[@]}"; do
    printf "%d) %s\n" "$((i+1))" "${networks[$i]}"
done
read -p "Enter your choice: " network_choice
network="${networks[$((network_choice-1))]}"



# Ask user which contract to deploy
printf "${GREEN}Available networks:${NC}\n"
for i in "${!contracts[@]}"; do
    printf "%d) %s\n" "$((i+1))" "${contracts[$i]}"
done
read -p "Enter your choice: " contract_choice
contract_choice=$((contract_choice-1))
contract="${contracts[$contract_choice]}"

# Construct the full script path
script_path="scripts/upgrades/$contract.upgrade.s.sol:Upgrade$contract"

forge clean
# Construct and run the forge command
forge script --chain "$network" "$script_path" --rpc-url "$network" --broadcast -vvvv 