# ANOTATIONS.MD

* Code samples:

Create a user:
mutation{
  registerUser(
      input:{
        firstName: "Luis",
        lastName: "Fernando",
    	  email: "luisfoxi@hotmail.com",
    		password: "123456"
      }
  ) {
    clientMutationId
    user {
      id
      email
      authenticationToken
    }
  }
}

Ler usuários:

{ users {
  edges {
    node {
      id
      firstName
      lastName
      authenticationToken
    }
  }
}
}
