package postgres

import (
	"database/sql"
	"fmt"
	"sync"

	"github.com/bontakun05/user-management/repository"

	"git.bluebird.id/logistic/commons/logger"

	//postgresql db driver
	_ "github.com/lib/pq"
)

var mutex = sync.RWMutex{}

type postgresReaderWriter struct {
	db *sql.DB
}

const driverName = "postgres"

//NewPostgresReaderWriter ...
func NewPostgresReaderWriter(conf repository.DBConfiguration) (repository.DatabaseReaderWriter, error) {
	connURL := fmt.Sprintf(
		"postgres://%s:%s@%s:%s/%s%s",
		conf.DBUser,
		conf.DBPassword,
		conf.DBHost,
		conf.DBPort,
		conf.DBName,
		conf.DBOptions)

	logger.Info(fmt.Sprintf(
		"Postgres connection: postgres://%s:%s@%s:%s/%s%s",
		conf.DBUser,
		"*************",
		conf.DBHost,
		conf.DBPort,
		conf.DBName,
		conf.DBOptions))

	db, err := sql.Open(driverName, connURL)
	if err != nil {
		return nil, err
	}
	return &postgresReaderWriter{
		db: db,
	}, nil
}

func (p *postgresReaderWriter) Close() error {
	return p.db.Close()
}
