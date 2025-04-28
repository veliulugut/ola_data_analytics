CREATE TABLE IF NOT EXISTS bookings (
    DateTime TEXT,
    Time TIME,
    Booking_ID VARCHAR(255),
    Booking_Status VARCHAR(255),
    Customer_ID VARCHAR(255),
    Vehicle_Type VARCHAR(255),
    Pickup_Location VARCHAR(255),
    Drop_Location VARCHAR(255),
    V_TAT VARCHAR(255),
    C_TAT VARCHAR(255),
    Cancelled_Rides_By_Customer VARCHAR(255),
    Cancelled_Rides_By_Driver VARCHAR(255),
    Incomplete_Rides VARCHAR(255),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value DECIMAL(10,2),
    Payment_Method VARCHAR(255),
    Ride_Distance DECIMAL(10,2), 
    Driver_Ratings DECIMAL(3,2),
    Customer_Rating DECIMAL(3,2),
    Vehicle_Images TEXT
);


#1. Retrieve all successful bookings:
Create View Successful_Bookings As
SELECT * FROM bookings WHERE Booking_Status = 'Success';

#2. Find the average ride distance for each vehicle type:
Create View Ride_Distance_For_Each_Vehicle As
    SELECT Vehicle_Type, AVG(Ride_Distance)
as avg_distance FROM bookings
GROUP BY Vehicle_Type;

#3. Get the total number of cancelled rides by customers:
Create View Cancelled_Rides_By_Customers As
SELECT COUNT(*) FROM bookings
WHERE Booking_Status = 'Canceled by Customer';


#4. List the top 5 customers who booked the highest number of rides:
Create View Top_5_Customers As
SELECT Customer_ID, COUNT(Booking_ID) as total_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC LIMIT 5;



#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Create View Rides_Cancelled_By_Drivers_Issues As
SELECT COUNT(*) FROM bookings
WHERE cancelled_Rides_by_Driver = 'Personal & Car related issue';

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Create View Max_Min_Driver_Rating As
SELECT MAX(Driver_Ratings) as max_rating,
MIN(Driver_Ratings) as min_rating
FROM bookings WHERE Vehicle_Type = 'Prime Sedan';


#7. Retrieve all rides where payment was made using UPI:
Create View UPI_Payment As
SELECT * FROM bookings
WHERE Payment_Method = 'UPI';

#8. Find the average customer rating per vehicle type:
Create View AVG_Cust_Rating As
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
FROM bookings
GROUP BY Vehicle_Type;

#9. Calculate the total booking value of rides completed successfully:
Create View total_successful_ride_value As
SELECT SUM(Booking_Value) as total_successful_ride_value
FROM bookings
WHERE Booking_Status = 'Success';


#10. List all incomplete rides along with the reason:
Create View Incomplete_Rides_Reason As
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes';