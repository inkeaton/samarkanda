# SAW_STARS
Our fate is in the stars!

## DESCRIPTION
 The objective of the project is to create a website where people can **follow** and **donate money** to specific constellations <br>

 The site will have a **blog** section under every constellation in memory, where users can debate on them. <br>

 Those are the main features of the site <br>

## PROJECT STRUCTURE AND CONVENTIONS 
The project is organized as follows:
+ It is mainly divided in:
    + the **public** folder, which contains the pages accessible via the browser
    + the **private** folder, which contains data, pages, and generally things not accessible via the browser
+ Inside the **root of public** we have the **main pages**. Those are the ones the user will actually access
+ Inside **resources** we have **media** files for the pages (sounds, images, etc)
+ Inside **snippets** we'll have reusable parts of code who mainly have **structural** purposes
+ Inside **scripts** we'll have reusable parts of code who mainly have **functional** purposes
+ Inside **styles** we'll have all the data required for **styling** (CSS, fonts, images, etc)
+ Inside **errors** we'll have the pages which are invoked in case of **specific errors**
    + Each of the 5 previous folders we'll be organized as follows:
        + A **commons** folder, which contains **shared files** between the main pages
        + A **folder for each page** which contains its **own files**
+ Each one of this pages may then have other substructures, depending on the circumstances <br>

For the coding, we'll use the following conventions, which may evolve during the development
+ **Snake case** (oh_yeah)
+ We'll use **descriptive names** for files and variables, as long as they don't go over 20 chars. In that case, we'll shorten some sections of the name, but those contraptions must be shared by names with the same word, for consistance
+ In php, we use **echo** to print, with **brackets**
+ _TO BE ADDED IN THE FUTURE_

## OBJECTIVES

This is a list of the different features to be implementes, in tiers of importance. The tier 0 must be complete to consider the project successful, the others are optional. They are not in order of implementation, just of importance

### TIER 0 (or what we have to do)

- [ ] General Styling
- [ ] Site presentation page
- [ ] Registration
- [ ] Login
- [ ] User profile page
- [ ] Edit User profile
- [ ] Internal Search Engine (in the main database)
- [ ] Logout
* [ ] Blog
* [ ] Shopping cart (as the user constellation list)
* [ ] Administrative area

### TIER 1 (or what'll make us look cool)

- [ ] Typescript
- [ ] Bento Grid Design
- [ ] Normalized and effective database structure

### TIER 2 (or what it would be fun to do)
- [ ] Report posts and users to admins
- [ ] Using nested posts structure in the blog (answers, etc)
- [ ] Internal Search Engine (For all data (users, posts, etc))
- [ ] Who we are page
- [ ] Create a mascotte :)

