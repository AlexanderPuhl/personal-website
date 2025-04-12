# Consistency App

## Development Setup using Docker

This project uses Docker Compose to provide a consistent development environment including the AdonisJS application server, a PostgreSQL database, and the Adminer database GUI.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or Docker Engine + Docker Compose) installed and running.
- Node.js and pnpm installed on your host machine (to run pnpm scripts).

### Initial Setup (First Time Only)

1.  **Clone the Repository:**

    ```bash
    git clone <your-repository-url>
    cd consistency-app-adonis
    ```

2.  **Install Host Dependencies:**
    Install the necessary Node.js dependencies on your host machine to run the package scripts.

    ```bash
    pnpm install
    ```

3.  **Environment File:**
    Copy the example environment file:

    ```bash
    cp .env.example .env
    ```

    - **Important:** Open the `.env` file and ensure the variables are suitable for your setup. You **must** generate an application key.

4.  **Generate App Key:**
    Run the following command on your host machine:

    ```bash
    node ace generate:key
    ```

    - This will generate a unique `APP_KEY` and update your `.env` file.

5.  **Start Docker Containers:**
    This command will build the necessary Docker images (if they don't exist or if the Dockerfile changed) and start the application, database, and Adminer containers in detached mode.

    ```bash
    pnpm run docker:up
    ```

    - Wait a few moments for the database container to initialize fully.

6.  **Run Database Migrations:**
    This command executes the database migrations _inside_ the running application container. **You only need to do this once** after the very first time you start the containers (or after creating new migration files).
    ```bash
    pnpm run migrate
    ```

### Running the Application (Daily Use)

1.  **Start Containers:**
    If the containers are not running, start them:

    ```bash
    pnpm run docker:up
    ```

2.  **Access the Application:**
    Open your web browser and navigate to: `http://localhost:3333`

3.  **Access Database GUI (Adminer):**
    Open your web browser and navigate to: `http://localhost:8081`
    Log in using the following details (based on your `.env` file):
    - **System:** `PostgreSQL`
    - **Server:** `consistency_db_dev`
    - **Username:** `postgres` (or your `PG_USER`)
    - **Password:** `postgres` (or your `PG_PASSWORD`)
    - **Database:** `consistency_adonis` (or your `PG_DB_NAME`)

### Stopping the Application

To stop and remove the Docker containers, network, and volumes (optional):

```bash
pnpm run docker:down
```
