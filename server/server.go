package server

import (
	"log"

	"git.bluebird.id/logistic/commons/cert"
	"git.bluebird.id/logistic/commons/logger"
	"git.bluebird.id/logistic/kit"
	"google.golang.org/grpc"

	"git.bluebird.id/logistic/commons/config"
	"git.bluebird.id/logistic/commons/constant"

	gr "git.bluebird.id/logistic/commons/grpc"
	"github.com/bontakun05/user-management/repository"
)

//Server server interface
type Server interface {
	Serve(addr string)
	Stop()
}

type grpcServer struct {
	kit   *kit.GRPCKit
	close func()
}

//NewGRPCServer ...
func NewGRPCServer() Server {
	cacert := config.Get(constant.CACertKey, "")
	serverCert := config.Get(constant.ServerCertKey, "")
	keyCert := config.Get(constant.KeyCertKey, "")
	var opts []grpc.ServerOption
	if cacert != "" && serverCert != "" && keyCert != "" {
		_, creds, err := cert.CreateTransportCredentials(cacert, serverCert, keyCert)
		if err != nil {
			log.Fatal(err)
		}
		opts = append(gr.Recovery(), grpc.Creds(*creds))

	} else {
		opts = gr.Recovery()
	}
	//set database
	repo, err := postgres.NewPostgresReaderWriter(repository.DBConfiguration{
		DBHost:     config.Get(constant.DBHostKey, "127.0.0.1"),
		DBName:     config.Get(constant.DBNameKey, "user_management"),
		DBOptions:  config.Get(constant.DBOptionsKey, ""),
		DBPassword: config.Get(constant.DBPasswordKey, "password"),
		DBPort:     config.Get(constant.DBPortKey, "password"),
		DBUser:     config.Get(constant.DBUserKey, "user"),
	})
	if err != nil {
		logger.Error(err)
	}
	server := kit.NewGRPCServer(opts...)

	return &grpcServer{
		kit: server,
		close: func() {
			repo.Close()
		},
	}
}

func (g *grpcServer) Serve(addr string) {
	logger.Info("Running server on " + addr)
	g.kit.Run(addr)
}

func (g *grpcServer) Stop() {
	g.close()
	g.kit.GracefulStop()
}
