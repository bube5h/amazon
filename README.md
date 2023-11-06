### Microservices

1. IAM Service
    * Responsible for authenticating user
    * Stores hashed user credentials
    * Only other services with API Key are allowed to access any APIs in IAM Service
2. User Service
    * Manages buyer and seller User Details(mobileNumber, emailId, address)
    * All APIs are authenticated
3. Inventory Service
    * It manages product details like price, product name, sellerId, product description
4. Order Management Service
    * It manages information like payment details, order status, order history
    * It communicates with the Inventory service via RabbitMQ queue

### Steps to spin up these services in local(for Mac os)

1. Install MySQL
    1. Version: 5.7
2. Install Java 17
3. Install RabbitMQ
4. Install Redis
5. Build commons repo
    1. `cd commons`
    2. `mvn install`
6. To Start IAM Service
    1. Directly on local:
        1. Run `com.amazon.iamservice.IamServiceApplication`
    2. Via Kubernetes
        1. Create a file `/etc/my.cnf` with content `bind-address = 0.0.0.0` and restart mysql, so
           that cluster node can access this.
        2. Install Docker Desktop
        3. Install minikube `brew install minikube`
        4. `cd iam-service`
        5. Start minikube `minikube start --driver docker --static-ip 192.168.200.200`
        6. make sure minikube's ip is `192.168.200.200` using ` minikube ip` command
        7. Run `eval $(minikube docker-env)`
        8. Run `docker build -t iam-service:1.0 .` to create docker image
        9. Run `kubectl apply -f deployment.yaml`
        10. Run `kubectl apply -f service.yaml`
7. To Start User Service
    1. Run `com.amazon.userservice.UserServiceApplication`
8. To Start Order Management Service
    1. Run `com.amazon.ordermanagementservice.OrderManagementServiceApplication`
9. To Start Inventory Service
    1. Run `com.amazon.inventoryservice.InventoryServiceApplication`



Flow Overview for SELLERs
1. HomePage can be viewed by anyone without logging in
2. SELLER need to sign up before creating a product
3. After logging in, Session will be started which can be identified by a `SESSION` key, user can do all other operations by just passing this SESSION as header in the request
4. Now, seller create or update the product that he/she owns
5. If the seller tries to modify other items, it will throw Authorization Error


Flow Overview for BUYERs
1. HomePage can be viewed by anyone without logging in
2. SELLER need to sign up before creating a product
3. After logging in, Session will be started which can be identified by a `SESSION` key, user can do all other operations by just passing this SESSION as header in the request
4. Now, the buyer can order a product, view the order history
    1. PESSIMISTIC LOCKING is being used to update product stock count
5. If the buyer cancels the product, then `Order Management Service` will send a async message to `Inventory Service` to modify the stock count back to previous one.


### Clustering
1. IAM Service is running on kubernetes with 2 nodes

### Architecture
<img width="1037" alt="image" src="https://github.com/bube5h/amazon/assets/34552173/56a3b9e6-038c-41c9-a3e0-71f5a6b3fcd6">

