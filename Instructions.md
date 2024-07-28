# Coding Challenge

## Information

Please find in the json folder 3 lists:

- 1x Verticals
- 1x Categories
- 1x Courses

As you can see in the JSON folder, categories have a parent called vertical and courses have a parent called categories. To serve the frontend, you will build the backend for that with an API.

- Set up the Models, Controllers, and API. Make sure that after the implementation, we should be able to update and create nested resources when we update parent object.
- Use Elastic Search to list items on recods collection page.
- Database: Postgres - please provide a seed file
- Validate uniqueness of `Name` of `category` and `vertical` across both models (if there is a category with name "TEST" then a vertical with name "TEST" can't be valid)
- Set up a oauth provider to protect the API

### Implementation expectations

Focus on proper structure rather than making each implementation 'perfect' - We would like to see your intention and the way you are able to handle scalable solutions, rather than fully workable solutions but wrongly structured and not scalable. If you don't have time to do something (we consider 10-12 hours would be a reasonable time for this challenge), you should clearly point that out and explain how you planned to implement it. If the code you provide is missing something and you don't list it, it will be assumed you didn't consider the requirement properly.

### Challenges you will face

- Ensuring that API can be scaled and is well-tested, abstracting business logic in reusable concerns or services

## Questions for future implementation

- How does your solution perform?
- How does your solution scale?
- What would you improve next?
