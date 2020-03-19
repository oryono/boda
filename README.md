# Boda

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Endpoints

```sh
GET /api/promos
```
This lists all the promo codes

```sh
GET /api/promos/{code}?origin=exampleOrigin&destination=exampleDestination
```
This shows if a code is valid. Accepts origin and destination parameters

```sh
GET /api/promos/status/active
```
This returns active promos

```sh
POST /api/promos
```
This allows you to create new promo code
