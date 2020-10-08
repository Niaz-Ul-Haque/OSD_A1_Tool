printf "\n --------- Program Status Codes -----------\n"
echo "| 0 means there are no errors.             |"
echo "| A non-zero exit code indicates an error. |"
echo " ------------------------------------------"
if [ $1 -eq 0 ]
then
    printf "\nProgram Status Code: ${GREEN}$1${NC}\n"
else
    printf "\nProgram Status Code: ${RED}$1${NC}\n"
fi