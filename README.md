# Boda ![Elixir CI](https://github.com/oryono/boda/workflows/Elixir%20CI/badge.svg)    [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/4fb6de0e68fb169245f6)

## CASE STUDY FOR Software Engineer (Backend - Elixir)
Hi and welcome to the SafeBoda Software Engineer challenge.
Here is the chance for you to convince us that you are the right person for the job!
We wish you good luck!
### SUBMISSION DEADLINE : 3 days from now.
#### HOW TO SUBMIT: 
The source code should be accessible via a git repository or sent to us as a zip file,
including git history.
#### THE CHALLENGE:
Intro : Safeboda want to give out promo codes worth x amount during events so people can get free
rides to and from the event. The flaw with that people can use the promo codes without going for the
event.
Task : Implement a promo code api with the following features.
- Generation of new promo codes for events
- The promo code is worth a specific amount of ride
- The promo code can expire
- Can be deactivated
- Return active promo codes
- Return all promo codes
- The promo code radius should be configurable
- To test the validity of the promo code, expose an endpoint that accept origin, destination, the
promo code. The api should return the promo code details and a polyline using the destination and
origin if promo code is valid and an error otherwise.

Please submit code as if you intended to ship it to production. The details matter. Tests are expected,
as is well written, simple idiomatic code.

#### Endpoints

```sh
GET /api/promos
```
This lists all the promo codes

```sh
GET /api/promos/details/{code}?origin=exampleOrigin&destination=exampleDestination
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
