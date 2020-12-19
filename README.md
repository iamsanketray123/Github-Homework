## Initial Thought Process:
<img src="https://user-images.githubusercontent.com/17732307/102682632-14fd4b00-41f1-11eb-90dc-ce5daf9df983.jpg" width="450" height="600">

• Drew screen wireframes to keep a mental note of design to build.<br/>
• Studied the GitHub documentation to find API endpoints to use.<br/>
• Wrote down the parameters that will be required for the task, and features I would like to implement.<br/>

#### Design Pattern:
I used MVC for the project and divided the task into three main logical components: the model, the view, and the controller. Each of these components is built to handle specific development aspects of the app. With the given time limit, this was my best option. If I were to do this in a real project which was maintained by a large team, something like RIBs or VIPER would make more sense.

#### Designing Components:
I decided to build the components using .xib files and programmatically, just to display familiarity with both methods. On a real project, I would code everything programmatically to avoid cumbersome merge conflicts associated with .xib files and storyboards.

#### Network Calls:
I created a Networking Manager(URLSession) to isolate all networking code into a single section. The API calls were parsed using the JSONDecoder and JSONSerialization. I used both approaches just to show familiarity. But using JSONDecoder is a lot cleaner and should be used in production level projects.

#### Features Incompete:
• I was unable to find an endpoint or a query parameter that would allow me to sort the results as per popularity by week/month/day. I did try to scout the docs for a very long time but was unable to find anything as per requirement. <br/>
• I would probably re-read the documents thoroughly and try to complete this if I had a bit more time. I tried to reach out to people over Slack to see if anyone had used anything similar, but considering it was the middle of the night, I had no luck.

#### Things I would do differently:
• I created a profile section for the user, to compensate for the previously incomplete feature. The profile section has a detailed view, which can be converted into a child view controller so that it can be reused in multiple places.<br/>
• Do everything programmatically.<br/>
• Create a separate branch for each feature.<br/>
• Write Testcases.<br/>
• Spend more time on design and adding subtle animations.<br/>
• Handle the app to make API calls, once the internet connection is restored. I ran into a bug at the last moment and wasn't able to fix it before time, hence I had to remove that part.<br/>
