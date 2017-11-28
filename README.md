# Collab

A wiki collaboration app on Rails. Collab features collaboration groups and varied authorization levels.
Employs Devise and Pundit to implement differentiated collaborator permissions. Accepts payment via Stripe. Offers markdown rendering.

#### Build Frameworks

- [Ruby](https://www.ruby-lang.org/)
- [Rails](http://rubyonrails.org/)

#### Gems and Dependencies

- [Bootstrap](http://getbootstrap.com/)
- [Bcrypt](https://rubygems.org/gems/bcrypt/)
- [Figaro](https://rubygems.org/gems/figaro/)
- [SendGrid](https://sendgrid.com/)
- [Devise]()
- [Pundit]()
- [Stripe]()
- [Markdown]()

### Project Objectives

- Users can register for an account.
- Users can view public posts and authorized private posts.
- Users can post under a given topic.
- Users can edit and delete their own posts.
- Users can comment on posts.
- Users can favorite posts and subscribe to email updates.
- Users can upvote or downvote posts.
- Admin users can create, edit, and delete topics, posts, and comments.

### Setup

A development version of this app can be run by cloning the repository, installing dependencies, and then running the rails server.

```
$ git clone https://github.com/jestann/rereadit.git <rereadit>
$ bundle install
$ rails s
```

### Configuration Variables

**Note:** This repository uses the file `application.yml` to initialize SendGrid. This file is not included in the repository.

To run this app, developers must create a `application.yml` file with the appropriate information as given in `application.example.yml`:

```
SENDGRID_USERNAME:
SENDGRID_PASSWORD:
```

### Database Seeding

This app includes a Ruby class in `random_data.rb` for generating effective test data and seeding the database via `seeds.rb`.

### Testing

This app includes a thorough set of tests using `rspec` in the `spec` directory.

### File Structure

This app follows the standard Rails file structure.

```
├── app
│   ├── assets
│   │   ├── images
│   │   └── stylesheets
│   │       └── ...
│   ├── controllers
│   │   └── ...
│   ├── mailers
│   │   └── ...
│   ├── models
│   │   └── ...
│   └── views
│       └── ...
├── bin
│   └── ...
├── config
│   ├── application.yml
│   └── ...
├── db
│   ├── seeds.rb
│   └── ...
├── lib
│   ├── random_data.rb
│   └── ...
├── log
│   └── ...
├── public
│   └── ...
├── spec
│   └── ...
├── tmp
│   └── ...
├── vendor
│   └── ...
├── config.ru
├── Gemfile
├── Rakefile
└── README.md
```

### Implementation

A test-drive version of the app exists [here](https://jestann-collab.herokuapp.com).

### Case Study

A description of the project case study exists [here](http://jessbird.me/portfolio/collab.html).

### Visuals

#### Main

<img alt="collab home 1" src="app/assets/images/readme/front-1.png" width="75%" align="center">

<img alt="collab home 2" src="app/assets/images/readme/front-2.png" width="75%" align="center">

#### Wiki

<img alt="collab wiki" src="app/assets/images/readme/wiki.png" width="75%" align="center">

#### Team

<img alt="collab team" src="app/assets/images/readme/team.png" width="75%" align="center">