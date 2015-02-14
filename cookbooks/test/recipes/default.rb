# test machine to experiment with various Ruby/Chef scripts

execute 'apt update' do
  command 'echo "test applied"'   
end