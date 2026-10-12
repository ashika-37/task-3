use task2;
show tables;
CREATE TABLE Seller (Seller_ID VARCHAR(10) PRIMARY KEY,Seller_Name VARCHAR(100) NOT NULL, Email VARCHAR(150) NOT NULL UNIQUE, 
Phone VARCHAR(20) NOT NULL, Address VARCHAR(255) NOT NULL);
CREATE TABLE Inventory (Inventory_ID INT AUTO_INCREMENT PRIMARY KEY, Product_ID INT NOT NULL, Seller_ID VARCHAR(10) NOT NULL, Stock_Quantity INT NOT NULL DEFAULT 0, Stock_Status VARCHAR(20) NOT NULL, Last_Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID), FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID),
CHECK (Stock_Quantity >= 0), CHECK (Stock_Status IN ('Available', 'Out of Stock')), UNIQUE (Product_ID, Seller_ID));
INSERT INTO Seller VALUES ('S101', 'Tech World', 'tech@gmail.com', '9876543210', 'Mumbai'), ('S102', 'Digital Store', 'digital@gmail.com', '9876543211', 'Pune'),
('S103', 'Fashion Hub', 'fashion@gmail.com', '9876543212', 'Delhi');
INSERT INTO Inventory (Product_ID, Seller_ID, Stock_Quantity, Stock_Status)VALUES
(101, 'S101', 20, 'Available'), (101, 'S102', 15, 'Available'),(102, 'S103', 50, 'Available');
SELECT * FROM Seller;
SELECT * FROM Inventory;
SELECT s.Seller_Name, p.Product_Name, i.Stock_Quantity, i.Stock_Status FROM Seller s JOIN Inventory i ON s.Seller_ID = i.Seller_ID
JOIN Product p ON i.Product_ID = p.Product_ID;
SELECT s.Seller_Name, COUNT(i.Product_ID) AS Total_Products FROM Seller s LEFT JOIN Inventory i ON s.Seller_ID = i.Seller_ID
GROUP BY s.Seller_ID, s.Seller_Name;
UPDATE Seller SET Phone = '9998887776' WHERE Seller_ID = 'S101';
INSERT INTO Seller VALUES ('S104', 'Smart Gadgets', 'smart@gmail.com', '9876543213', 'Bengaluru');
UPDATE Inventory SET Stock_Quantity = Stock_Quantity + 10, Stock_Status = 'Available' WHERE Product_ID = 101 AND Seller_ID = 'S101';
 DELETE FROM Inventory WHERE Product_ID = 102 AND Seller_ID = 'S103';
 SELECT DISTINCT p.Product_ID, p.Product_Name FROM Product p JOIN Inventory i ON p.Product_ID = i.Product_ID WHERE i.Stock_Quantity > 0;
SELECT p.Product_ID, p.Product_Name FROM Product p WHERE NOT EXISTS (SELECT 1 FROM Inventory i WHERE i.Product_ID = p.Product_ID AND i.Stock_Quantity > 0);
SELECT Product_ID, Stock_Quantity FROM Inventory WHERE Stock_Quantity < 10;

SELECT s.Seller_Name,
       COUNT(DISTINCT i.Product_ID) AS Products_Supplied,
       COALESCE(SUM(i.Stock_Quantity), 0) AS Available_Stock
FROM Seller s
LEFT JOIN Inventory i ON s.Seller_ID = i.Seller_ID
GROUP BY s.Seller_ID, s.Seller_Name;
SELECT p.Product_Name, i.Stock_Quantity, i.Stock_Status FROM Product p JOIN Inventory i ON p.Product_ID = i.Product_ID;
SELECT COUNT(DISTINCT Product_ID) AS Total_Products_Available FROM Inventory WHERE Stock_Quantity > 0;
SELECT COUNT(*) AS Products_Out_Of_Stock FROM Product p WHERE NOT EXISTS (SELECT 1 FROM Inventory i WHERE i.Product_ID = p.Product_ID AND i.Stock_Quantity > 0
);
SELECT p.Product_Name, SUM(i.Stock_Quantity) AS Total_Stock FROM Product p JOIN Inventory i ON p.Product_ID = i.Product_ID
GROUP BY p.Product_ID, p.Product_Name ORDER BY Total_Stock DESC LIMIT 5;
SELECT AVG(Stock_Quantity) AS Average_Inventory FROM Inventory;
SELECT SUM(Stock_Quantity) AS Total_Stock FROM Inventory;
SELECT * FROM Seller;
SELECT * FROM Inventory;



























































































































