
# Running MongoDB on The NGD Systems Computational Storage Drives “CSDs”
The most cost effective solution for delivering world class performance to your mongoDB Data Nodes. MongoDB was originally engineered to use inexpensive Storage Servers with HDDs at the heart of the cluster. This older HDD technology cannot keep pace with the demands of today’s data intensive applications. Big Data, Analytics, IoT, and AI/ machine learning are just a few of the data hungry applications that need a higher level of performance.

# Replication
Using 2 CSDs for replication in the host server vs 3 separate servers. By creating multiple replication nodes using a single server you need far less resources for each cluster. You can also set up multiple replication sets per storage server to maximize your savings.

![image](https://user-images.githubusercontent.com/31414094/138521393-85315fbc-0249-4316-b44b-18026bc525cf.png)
![image](https://user-images.githubusercontent.com/31414094/138521408-edaf66c5-95f1-4a4b-9edc-6947dbc67fdb.png)


# Sharding
mongoDB can take advantage of spreading data across multiple drives giving the ability to use the efficiency and performance of parallel dynamics. You can have as many shards per server as there are available drive slots. For example, 32 8TB CSDs in a 1U server will give you up to 32 shards with an additional 128 processors for added capabilities like creating a node from each CSD.

![image](https://user-images.githubusercontent.com/31414094/138521659-21d7a2a2-98f8-4d0a-82c1-c2bb93e7db0a.png)


# Sharding and Replication 
Using a single storage Server with multiple shards will reduce data center foot print and overall cost while providing more performance per host and less latency while replicating.

![image](https://user-images.githubusercontent.com/31414094/138522222-e2df7598-08f1-44fa-b3c0-704a80cf19d2.png)

# Performance and Scalability
You gain performance linearly as you add Capacity with CSDs, 
Performance, Cost Savings and more Efficiency from your applications 

![image](https://user-images.githubusercontent.com/31414094/138522462-4cb866d7-87fd-466a-8788-61708ff0a29d.png)


# Install MongoDB on NGD CSDs

Installing MongoDB on NGD CSD for Ubuntu 16.04 Click [here](./MongoDB_NGD_CSD_Ubuntu_16.04.md).

Installing MongoDB on NGD CSD for Ubuntu 18.04 Click [here](./MongoDB_NGD_CSD_Ubuntu_18.04.md).

MongoDB Cluster Running on NGD Computational Storage Devices Click [here](./MongoDB_Cluster/README.md).

