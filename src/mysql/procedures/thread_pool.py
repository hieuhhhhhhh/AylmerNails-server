import threading
import queue

# Create a global job queue for worker threads to process
job_queue = queue.Queue()


# Worker function to handle connection closure
def worker():
    while True:
        task = job_queue.get()  # Block until a task is available
        task()  # This will execute the function passed to the queue
        job_queue.task_done()


# Start multiple worker threads to handle connection closures
num_workers = 3  # Specify how many worker threads you want
for _ in range(num_workers):
    worker_thread = threading.Thread(target=worker, daemon=True)
    worker_thread.start()
