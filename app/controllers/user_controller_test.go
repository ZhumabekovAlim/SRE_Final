package controllers

import (
	"bytes"
	"encoding/json"
	"github.com/gieart87/gotoko/app/models"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRegister(t *testing.T) {
	server := SetupServer()

	// Create a test request to the register page
	req, err := http.NewRequest("GET", "/register", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Record the response
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(server.Register)
	handler.ServeHTTP(rr, req)

	// Check the status code is what we expect
	assert.Equal(t, http.StatusOK, rr.Code, "Handler returned wrong status code")
}

func TestDoRegister(t *testing.T) {
	server := SetupServer()

	// Create a test user
	user := models.User{
		FirstName: "Test",
		LastName:  "User",
		Email:     "test@example.com",
		Password:  "password123",
	}

	// Marshal user data into JSON
	userData, err := json.Marshal(user)
	if err != nil {
		t.Fatal(err)
	}

	// Create a request to the DoRegister handler
	req, err := http.NewRequest("POST", "/register", bytes.NewBuffer(userData))
	if err != nil {
		t.Fatal(err)
	}
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	// Create a ResponseRecorder to record the response
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(server.DoRegister)
	handler.ServeHTTP(rr, req)

	// Check the status code is what we expect
	assert.Equal(t, http.StatusSeeOther, rr.Code, "Handler returned wrong status code")

	// Check that the location header is correct
	location, err := rr.Result().Location()
	if err != nil {
		t.Fatal(err)
	}
	assert.Equal(t, "/", location.Path, "Handler redirected to wrong location")
}

// SetupServer initializes the server for testing
func SetupServer() *Server {
	server := &Server{}
	// Initialize your server with necessary dependencies
	// e.g., database connection, router, etc.
	server.initializeRoutes()
	return server
}
