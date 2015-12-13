begin
  [
    {
      id:         1,
      first_name: 'Kamil',
      last_name:  'Lelonek',
      email:      'squixy.sln@gmail.com',
      phone:      '+1 70 29 45 45 58',
    },
    {
      id:         2,
      first_name: 'Andrzej',
      last_name:  'Filipowicz',
      email:      'afilipowicz.4@gmail.com',
      phone:      '+48 500 600 700',
    },
    {
      id:         3,
      first_name: 'Michał',
      last_name:  'Załęcki',
      email:      'michal@zalecki.pl',
      phone:      '+48 600 700 800',
    },
    {
      id:         4,
      first_name: 'Mateusz',
      last_name:  'Maciaszek',
      email:      'mateusz.maciaszekhpc@gmail.com',
      phone:      '+48 700 800 900',
    },
  ].each &Braintree::Services::CreateCustomer.method(:call)
rescue Braintree::Services::CreateCustomer::Error
  $stderr.puts $!.message
end
