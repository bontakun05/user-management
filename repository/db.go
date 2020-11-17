package repository

import (
	"io"
)

//DatabaseReaderWriter interface for database access
type DatabaseReaderWriter interface {
	io.Closer
}

//DBConfiguration ...
type DBConfiguration struct {
	DBHost     string
	DBPort     string
	DBUser     string
	DBPassword string
	DBName     string
	DBOptions  string
}
