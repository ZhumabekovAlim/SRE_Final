package controllers

import (
	"github.com/gieart87/gotoko/app/consts"
	"net/http"

	"github.com/gieart87/gotoko/app/middlewares"
	"github.com/gorilla/mux"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	MemoryUsedBytes = prometheus.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "memory_used_bytes",
			Help: "memory used in bytes",
		},
		[]string{"area"},
	)
	MemoryMaxBytes = prometheus.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "memory_max_bytes",
			Help: "memory max in bytes",
		},
		[]string{"area"},
	)

	// System CPU usage
	systemCPUUsage = prometheus.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "system_cpu_usage",
			Help: "System CPU usage",
		},
		[]string{"instance"},
	)

	// HTTP request metrics
	httpRequestDurationSeconds = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name: "http_server_requests_seconds",
			Help: "HTTP request duration in seconds",
		},
		[]string{"uri"},
	)
	httpRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total",
			Help: "Total number of HTTP requests",
		},
		[]string{"status"},
	)

	// Process uptime
	processUptimeSeconds = prometheus.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "process_uptime_seconds",
			Help: "Process uptime in seconds",
		},
		[]string{"instance"},
	)

	loginErrors = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "login_errors_total",
			Help: "Total number of login errors.",
		},
		[]string{"type"},
	)
)

func init() {
	prometheus.MustRegister(MemoryUsedBytes)
	prometheus.MustRegister(MemoryMaxBytes)
	prometheus.MustRegister(systemCPUUsage)
	prometheus.MustRegister(httpRequestDurationSeconds)
	prometheus.MustRegister(httpRequestsTotal)
	prometheus.MustRegister(processUptimeSeconds)
	prometheus.MustRegister(loginErrors)

}

func MetricsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		httpRequestsTotal.With(prometheus.Labels{"method": r.Method, "endpoint": r.URL.Path}).Inc()
		next.ServeHTTP(w, r)
	})
}

func (server *Server) initializeRoutes() {
	server.Router = mux.NewRouter()
	server.Router.HandleFunc("/", server.Home).Methods("GET")

	server.Router.HandleFunc("/login", server.Login).Methods("GET")
	server.Router.HandleFunc("/login", server.DoLogin).Methods("POST")
	server.Router.HandleFunc("/register", server.Register).Methods("GET")
	server.Router.HandleFunc("/register", server.DoRegister).Methods("POST")
	server.Router.HandleFunc("/logout", server.Logout).Methods("GET")
	server.Router.Handle("/metrics", promhttp.Handler()).Methods("GET")

	server.Router.HandleFunc("/products", server.Products).Methods("GET")
	server.Router.HandleFunc("/products/{slug}", server.GetProductBySlug).Methods("GET")

	server.Router.HandleFunc("/carts", server.GetCart).Methods("GET")
	server.Router.HandleFunc("/carts", server.AddItemToCart).Methods("POST")
	server.Router.HandleFunc("/carts/update", server.UpdateCart).Methods("POST")
	server.Router.HandleFunc("/carts/cities", server.GetCitiesByProvince).Methods("GET")
	server.Router.HandleFunc("/carts/calculate-shipping", server.CalculateShipping).Methods("POST")
	server.Router.HandleFunc("/carts/apply-shipping", server.ApplyShipping).Methods("POST")
	server.Router.HandleFunc("/carts/remove/{id}", server.RemoveItemByID).Methods("GET")

	server.Router.HandleFunc("/orders/checkout", middlewares.AuthMiddleware(server.Checkout)).Methods("POST")
	server.Router.HandleFunc("/orders/{id}", middlewares.AuthMiddleware(server.ShowOrder)).Methods("GET")

	server.Router.HandleFunc("/payments/midtrans", server.Midtrans).Methods("POST")

	server.Router.HandleFunc("/admin/dashboard", middlewares.AuthMiddleware(middlewares.RoleMiddleware(server.AdminDashboard, server.DB, consts.RoleAdmin, consts.RoleOperator))).Methods("GET")
	staticFileDirectory := http.Dir("./assets/")
	staticFileHandler := http.StripPrefix("/public/", http.FileServer(staticFileDirectory))
	server.Router.PathPrefix("/public/").Handler(staticFileHandler).Methods("GET")
}
