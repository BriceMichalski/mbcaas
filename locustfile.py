from locust import HttpUser, task, constant_throughput

class Benchmark(HttpUser):

    wait_time = constant_throughput(52)

    def on_start(self):
        self.client.headers = {'Host': 'whoami.mbcaas.com'}

    @task
    def GetHome(self):
        self.client.get("/")
