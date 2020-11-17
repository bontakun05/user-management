package main

import (
	"fmt"

	"git.bluebird.id/logistic/commons/config"
	"git.bluebird.id/logistic/commons/constant"
	"git.bluebird.id/logistic/user-management/server"
)

func main() {
	//os.Setenv("GOOGLE_APPLICATION_CREDENTIALS", "pubsub.json")
	sv := server.NewGRPCServer()
	sv.Serve(fmt.Sprintf(":%s", config.Get(constant.ServicePortKey, "9084")))
	defer sv.Stop()
}
