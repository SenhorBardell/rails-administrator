// const {Router, Route, Link, hashHistory} = ReactRouterDOM;
const Router = ReactRouterDOM.Router;
const Route = ReactRouterDOM.Route;
const Link = ReactRouterDOM.Link;

class Routes extends React.Component {
    render() {
        return (
            <Router>
                <nav>
                    <Link to="/">App</Link>
                    <Link to="/about">About</Link>
                </nav>
                <Route exact path="/" component={Home}/>
                <Route exact path="/about" component={About}/>
            </Router>
        )
    }
}

class Home extends React.Component {
    render() {
        return (
            <div>
                <h1>Home</h1>
            </div>
        )
    }
}

class About extends React.Component {
    render() {
        return (
            <div>
                <h1>About</h1>
            </div>
        )
    }
}
