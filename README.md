# janina

## Requirements
* Ruby 2.3.3+

## Development Setup
1. Clone the repository
```
$ git clone git@github.com:ialidzhikov/janina.git
$ cd janina
```

2. Install dependencies
```
$ bundle install
```

3. Setup database
```
$ bundle exec rake db:migrate
```

4. (Optinal) Import admin users from admin/users/admins.json
```
$ bundle exec rake db:users:import_admins
```

5. Run
```
$ bundle exec ruby app.rb
```
