User.create(username: "mina", email: "mina@test.com", password: "treat", full_name: "Mina Jeanne")
User.create(username: "ellie", email: "ellie@test.com", password: "walkie", full_name: "Ellie Bellie")
User.create(username: "dom", email: "dom@test.com", password: "munch", full_name: "Dom Santiago")

Restaurant.create(name: "Casa", cuisine: "Tapas", location: Hartsdale, NY)
Restaurant.create(name: "Mama's Kitchen", cuisine: "Comfort Food", location: Hartsdale, NY)
Restaurant.create(name: "Backyard Grill", cuisine: "BBQ", location: Tuckahoe, NY)

Review.create(title: "Best Treats Ever", experience: "The treats here are the best I've ever had!", rating: 5, user_id: 1, restaurant_id: 1)
Review.create(title: "So Yummy", experience: "No one makes dinner like Mama.", rating: 4, user_id: 2, restaurant_id: 2)
Review.create(title: "Finger Lickin' Good", experience: "The food was better than anything you'd find in your own backyard!", rating: 5, user_id: 3, restaurant_id: 3)
