# Status

Approved

Zhivko Angelov, Viktor Isaev, Kiril Stoilov

# Context

Security is one of the driving characteristics of ClearView. We need an authentication / authorization solution for our 
service, that is:

1. Fully secure and conforms to the most recent security standards.
2. Role-based access control to differentiate between clients, companies, and admins.
3. Simple to work with (has minimal development costs).
4. Simple to operate (has minimal operating costs).
5. Scales well to support varying loads without compromising security or performance.
6. Supports user federation and all popular authentication methods.

# Decision

We choose to use [AWS Cognito](https://aws.amazon.com/es/cognito/) and OIDC protocol for authentication, because it 
matches all our criteria stated above. We use role-based authorization with JWT tokens.

We also considered [Auth0](https://auth0.com/) as an alternative, as it:

- Also matches the requirements
- Has seemingly better support
- Has reportedly better logging

However, we have decided to still use AWS Cognito, because Cognito has better pricing compared to Auth0.

# Consequences

Positive:

- We will be able to implement authentication / authorization easily and quickly and have simplified user management.
- Seamless integration with AWS: since Cognito integrates natively with other AWS services like API Gateway and Lambda, 
it simplifies securing API endpoints.
- Our authentication solution will have compliance with all required security regulations.
- We will have scalability and availability of our authentication solution out of the box.

Negative:

- We will be moderately vendor-locked.
- We will be limited in customizing our authentication solution.

This decision is reversible - we may be able to switch to another authentication service given that we use standard 
OIDC authentication protocol.

# See also

- [Auth0 vs AWS Cognito comparison](https://brocoders.com/blog/auth0-vs-cognito/)