# 1. What are the main features of redis?

Redis is an open-source in-memory data structure store that can be used as a database, cache, and message broker. Some of the main features of Redis include:

## In-memory storage:
Redis stores all data in-memory, which makes it very fast.

## Data structures:
Redis supports a variety of data structures, including strings, hashes, lists, sets, and sorted sets.

## Persistence:
Redis can persist data to disk, allowing data to be recovered in the event of a server crash or restart.

## Replication:
Redis can be configured to replicate data to one or more slave nodes, providing high availability and data redundancy.

# 2. Write down the limitations of redis?

While Redis is a highly popular and versatile data store, it does have some limitations that should be considered when choosing a data storage solution. 

## Limited storage capacity:
Since Redis stores all data in-memory, its storage capacity is limited by the amount of available RAM.

## Not suitable for all data types:
While Redis supports a variety of data structures, it is not well-suited for storing large blobs of data or unstructured data.

## Single-threaded: 
Redis is single-threaded, which means that it can only handle one request at a time.

## No built-in security:
Redis does not have built-in authentication or access control mechanisms, which means that securing Redis requires additional configuration.


# 3. Perform a basic CRUD operation using redis.


```
import redis

# Create operation
SET name Name

# Read operation
GET name 
# Output: "Name"

# Update operation
SET name "MY Name"

# Delete operation
DELETE name

```

# 4. Explain TTL command with an example.
TTL stands for "Time to Live," and it is a value in an Internet Protocol (IP) packet that determines the maximum amount of time the packet is allowed to remain in the network before being discarded.
```
set medicine "Paracetamol" ex 12000
TTL medicine
```

FIrst, we set the key by using the set command.<br>
Then we need to specify the time with expired keywords like ex.<br>
For each time the key is executing and the timeout count is decreased.


# 5. Create a transaction in redis to perform the following operations.
    ● Create two keys in a single line and one key differently. (one value
    should be number)
    ● Read any two value in a single line
    ● Increment the number value
    ● Expire any two keys after some time


```
MULTI
SET key1 "value1" SET key2 "value2" SET key3 42
GET key1 GET key3
INCR key3
EXPIRE key1 60 EXPIRE key2 120
EXEC
```
In this example, the MULTI command starts a new Redis transaction, and the subsequent commands are queued up for execution as a single atomic operation. The SET command is used to create two keys, key1 and key2, with string values "value1" and "value2", respectively. The third key, key3, is created separately with a numeric value of 42.






    