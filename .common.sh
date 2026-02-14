# Function to prompt for yes/no confirmation
confirm() {
    # Set default response to Yes if nothing is entered (indicated by the uppercase Y in the prompt)
    read -r -p "${1:-Continue?} [Y/n]: " response

    # Convert the response to lowercase for robust comparison
    case "$response" in
        [yY]|[yY][eE][sS]|"")
            # Return 0 for 'yes' or empty input (success)
            return 0
            ;;
        [nN]|[nN][oO])
            # Return 1 for 'no' (failure)
            return 1
            ;;
        *)
            # For invalid input, echo a message and loop again
            echo "Invalid response. Please answer yes or no."
            confirm "$1"
            ;;
    esac
}
