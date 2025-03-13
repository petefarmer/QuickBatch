# QuickBatch

QuickBatch is a Ruby on Rails application for managing inventory, purchase orders, and sales orders. It provides a streamlined interface for handling items, customers, and order management.

## Features

- Item management with types and subtypes
- Customer management
- Purchase order management
- Sales order management
- Admin interface for system configuration
- Modern UI with Tailwind CSS
- Responsive design

## Requirements

- Ruby 3.2.0 or higher
- Rails 7.0.0 or higher
- PostgreSQL
- Node.js and Yarn

## Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/QuickBatch.git
cd QuickBatch
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Setup the database:
```bash
rails db:create db:migrate
```

4. Start the development server:
```bash
./bin/dev
```

Visit http://localhost:3000 to see the application.

## Development

The application uses:
- Ruby on Rails for the backend
- Tailwind CSS for styling
- Stimulus.js for JavaScript interactions
- PostgreSQL for the database

## License

This project is licensed under the MIT License - see the LICENSE file for details.
