# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create users
User.create(user: "John", password: "password")
User.create(user: "Mary", password: "password")

# # Create threads
10.times do |i|
    ThreadPage.create(
        title: "Title", 
        body: "You will be making a simple web forum in this assignment. Through the assignment, you will learn about the programming skills required for CVWO’s summer projects and go through a website development cycle. The focus of this assignment is to maximise learning of proper code structure, coding techniques and familiarity with various development tools. You are expected to build up a good web development foundation through this assignment, and prepare yourself for a development cycle during your stint over the summer.", 
        user_id: 1
    )
end

ThreadPage.create(
    title: "Commented Thread", 
    body: "You will be making a simple web forum in this assignment. Through the assignment, you will learn about the programming skills required for CVWO’s summer projects and go through a website development cycle. The focus of this assignment is to maximise learning of proper code structure, coding techniques and familiarity with various development tools. You are expected to build up a good web development foundation through this assignment, and prepare yourself for a development cycle during your stint over the summer.",
    user_id: 1
)

# Create comments
10.times do |i|
    Comment.create(
        body: "To achieve the above, this assignment is split into several levels. You will incremen- tally gain an understanding of different web development principles. At the end, you will produce a simple web application that allows several people to discuss topics and collaborate online.",
        user_id: 2,
        thread_page_id: 11
    )
end

Comment.create(body: "Latest comment!", user_id: 2, thread_page_id: 11)