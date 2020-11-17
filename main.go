package main

import (
	"fmt"

	"github.com/bontakun05/user-management/server"

	"git.bluebird.id/logistic/commons/config"
	"git.bluebird.id/logistic/commons/constant"
)

func main() {
	//os.Setenv("GOOGLE_APPLICATION_CREDENTIALS", "pubsub.json")
	sv := server.NewGRPCServer()
	sv.Serve(fmt.Sprintf(":%s", config.Get(constant.ServicePortKey, "9084")))
	defer sv.Stop()
}
