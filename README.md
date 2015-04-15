# docker-qless
A container running the MOZ Qless UI - a redis backed job queue (inspired by resque)


### Run with docker

	docker run -d --link redis:qless_redis -p ::3000 johnjansen/qless:latest

### Sample systemd service (CoreOS etc)
	[Unit]
	Description=qless-ui
	After=docker.service
	Requires=docker.service

	[Service]
	TimeoutStartSec=0
	EnvironmentFile=/etc/environment
	ExecStartPre=/usr/bin/docker pull johnjansen/qless:latest
	ExecStartPre=-/usr/bin/docker rm qless-ui
	ExecStart=/bin/sh -c '/usr/bin/docker run --rm --name qless-ui  --link redis_dynamic_ambassador:qless_redis johnjansen/qless'
	ExecStop=/usr/bin/docker stop qless-ui
	ExecStopPost=-/usr/bin/docker rm qless-ui
	Restart=always
	RestartSec=10s

	[X-Fleet]
	MachineMetadata=role=control
