# Template for producer-consumer model robots using work items

This template contains a working robot implementation that has the basic structure where one part produces work items from input and another part that consumes those work items. 

> The [producer-consumer](https://en.wikipedia.org/wiki/Producer%E2%80%93consumer_problem) model is not limited to two steps, it can continue so that the consumer generates further work items for the next step and so on.

The template tries to keep the amount of functional code at a minimum so you have less to clear out and replace with your own implementation, but some functional logic is needed to have the template working and guiding the key parts.

> We recommended checking out the article "[Using work items](https://robocorp.com/docs/development-guide/control-room/work-items)" before diving in.


> Also a fully functional example robot can be found at: [Web Store Order Processor Using Work Items](https://robocorp.com/portal/robot/robocorp/example-web-store-work-items)


## Tasks

The robot is split into two tasks, meant to run as separate steps in Control Room. The first task generates (produces) data, and the second one reads (consumes) and processes that data.

### The first task (the producer)

- Splits the example Excel file into work items for the consumer

### The second task (the consumer)

- Demonstrates the different exceptions usage in robot with a simulated "Login" that fails randomly.
  - Highlights the use of APPLICATION exception
- Loops through the work items and just creates a logs row for each
  - Highlights the use of BUSINESS exception
- Documentation on [Work item exception handling](https://robocorp.com/docs/development-guide/control-room/work-items#work-item-exception-handling)

