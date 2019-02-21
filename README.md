# README

#### secret_token: 77b2bfec16e65dcd109e236a9ef47f9ee4b0

## API documentation

### Customers list:

- URL: http://localhost:3000/api/v1/customers
- method: GET
- Parameters:
  - headers {
     - secret-token: secret_token
  - }
  - URL parameter: {}

### Filter Customers list:

- URL: http://localhost:3000/api/v1/customers
- method: GET
- Parameters:
  - headers {
     - secret-token: secret_token
  - }
  - URL parameter: {
    - filter[name]
    - filter[street]
  - }


### create customers with existing address:

- URL: http://localhost:3000/api/v1/customers
- method: POST
- Parameters:
  - headers {
     - secret-token: secret_token
  - }
  - body: {
    - customer[name]
    - customer[address_id]
  - }


### create customers with new address:

- URL: http://localhost:3000/api/v1/customers
- method: POST
- Parameters:
  - headers {
     - secret-token: secret_token
  - }
  - body: {
    - customer[name]
    - customer[address_attributes][street]
    - customer[address_attributes][city]
    - customer[address_attributes][zip_code]
  - }

### destroy customer with id

- URL: http://localhost:3000/api/v1/customers/:id
- method: DELETE
- Parameters:
  - headers {
     - secret-token: secret_token
  - }
  - url parameter: {
    - id (customer id)

## How to Setup App?
- install Ruby version: 2.5.3
- git clone git@github.com:3lviend/api_application.git
- cd api_application/
- bundle install
- rake db:create
- rake db:migrate
- rake db:seed
- rails server

# How to run the test suite?
- open terminal
- make sure database has been settled up
- run command 'rspec' on terminal

