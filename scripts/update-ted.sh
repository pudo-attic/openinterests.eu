if [ -z "$OPINT_DATA_PATH" ]; then
    echo "Need to set OPINT_DATA_PATH"
    exit 1
fi

echo "WARNING: This scripts needs 'sudo' to continue..."

export TED_PATH="$OPINT_DATA_PATH/ted"
cd $TED_PATH

#python make_list.py
wget -c -P $TED_PATH/isos -i cd $TED_PATH/iso_list.txt

mkdir -p mnt
mkdir -p xml

for ISO in $TED_PATH/isos/*; do
  echo $ISO
  sudo mount -o rw $ISO mnt
  for DIRX in mnt/*/*; do
    if [ -d "$DIRX/TED-XML" ]; then
      FN=`ls "$DIRX/TED-XML"`
      cd xml
      tar xvfzk ../$DIRX/TED-XML/$FN
      cd ..
    fi
  done
  sudo umount mnt
done
