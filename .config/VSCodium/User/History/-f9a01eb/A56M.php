<!DOCTYPE html>
<html>
  <head>
    <title> Login </title>
  </head>
  <body>
    <form type='submit' action='javascript:getAllUsers()' >
      <button type='submit'>Get All Users</button>
    </form><br><br><br>
    <form id='get-user-form' type='submit' action='javascript:getUser()' >
      Email <input name='email' type='email' value='friday99@outlook.it'><br>
      <button type='submit'>Get User</button>
    </form><br><br><br>
    <form id='put-user-form' type='submit' action='javascript:putUser()' >
      Email <input name='email' type='email' value='friday99@outlook.it'><br>
      Password <input name='pwd' type='password' value='arun123'><br>    
      First Name <input name='firstName' type='text' value='Arun'><br>
      Last Name <input name='lastName' type='text' value='Mathiyalakan'><br>
      <button type='submit'>Put User</button>
    </form><br><br><br>
    <form id='set-user-form' type='submit' action='javascript:setUser()' >
      Email <input name='email' type='email' value='friday99@outlook.it'><br>
      Password <input name='pwd' type='password' value='arun123'><br>    
      First Name <input name='firstName' type='text' value='Arun'><br>
      Last Name <input name='lastName' type='text' value='Mathiyalakan'><br>
      Username <input name='username' type='text' value='arun99.dev'><br>
      <button type='submit'>Set User</button>
    </form><br><br><br>
  </body>
  <script>
    const getAllUsers = () => {
      fetch('./api/user/getAllUsers.php')
      .then(response => response.json()).then(result => { console.log(result) })
    }

    const getUser = () => {
      const form = document.getElementById('get-user-form')
      fetch('./api/user/getUser.php?email=' + form.email.value)
      .then(response => response.json()).then(result => { console.log(result) })
    }

    const putUser = () => {
      const form = document.getElementById('put-user-form')
      const formData = new FormData()
      formData.append('email', form.email.value)
      formData.append('pwd', form.pwd.value)
      formData.append('firstName', form.firstName.value)
      formData.append('lastName', form.lastName.value)
      fetch('./api/user/putUser.php', { method: 'POST', body : formData })
      .then(response => response.json()).then(result => { console.log(result) })
    }

    const setUser = () => {
      const form = document.getElementById('set-user-form')
      const formData = new FormData()
      formData.append('email', form.email.value)
      formData.append('pwd', form.pwd.value)
      formData.append('firstName', form.firstName.value)
      formData.append('lastName', form.lastName.value)
      formData.append('username', form.username.value)
      fetch('./api/user/setUser.php', { method: 'POST', body : formData })
      .then(response => response.json()).then(result => { console.log(result) })
    }
  </script>
</html>

<!-- TODO:
  - error handling
  - user auth checker
  - session

  - mutations:
    - insert:
      - review (USER)
      - register (USER)
      - star (ADMIN)
      - sub (ADMIN)
      - constellation (ADMIN)
    - delete:
      - review (USER)
      - user (ADMIN)
      - star (ADMIN)
      - sub (ADMIN)
      - constellation (ADMIN)
    - update:
      - review (USER)
      - user (USER)
      - user (ADMIN)
      - star (ADMIN)
      - sub (ADMIN)
      - constellation (ADMIN)
-->
