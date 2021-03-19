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


* Criar Posts
mutation{signIn(input: {
  email: "luisfoxi@hotmail.com"
  password: "123456"
}) {
  clientMutationId
}
  createPost(input: {attributes: {
    title: "Título Teste"
    body: "Body Teste"
  }}) {
    clientMutationId
  }
}


* Ler usuários e posts
{ users {
  edges {
    node {
      id
      firstName
      lastName
      fullName
      email
      authenticationToken
      posts {
        id
        title
        body
        comments {
          id
        }
      }
    }
  }
} }

