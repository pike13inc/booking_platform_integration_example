# Intergrating your Membership Aggregator Application with Front Desk

Note: The code included in this repository is strictly for example purposes only and should
not be considered production ready.


## Setting up your integration

### Authentication and authorization

This example assumes you have already obtained an access token via the OAuth2 flow.

In order to obtain the appropriate authorization, the access token must be associated
with a staff member that has manager permissions or higher. In general, we recommend
the business owner creates a separate manager or owner profile for the integration
to make it easier to track activity.

 * [Documentation](https://developer.frontdeskhq.com/docs/api/v2#authentication)



### Create a pack product to pay for a visit

If your application is responsible for payment of the visit, you will likely want to create
a PackProdcut in Front Desk.  Later you will reference this PackProduct when creating Packs
which will be used to mark individual visits as paid.  This will allow business owners to report on
which visits were paid for by your service within Front Desk reporting.  If are simply
registering clients for classes and not involved in memberships or payments, you may be able
to skip this step.

 * [Example code](lib/setup.rb)
 * [Documentation](https://developer.frontdeskhq.com/docs/api/v2?preview=true#endpoint-pack-product)



## Retrieving the schedule

In order to register clients for classes (event occurrences) in Front Desk, you will likely need to retrieve
the schedule in order to display it to clients.

 * [Example code](lib/schdeule.rb)
 * [Documentation](https://developer.frontdeskhq.com/docs/api/v2#endpoint-eventoccurrence)



## Finding and creating clients

In order to reconcile clients in your system to clients in Front Desk, we recommend looking
them up by email (although you can also search by name or barcode as well).

If no match is found, you will want to create a new client.

 * [Example code](lib/person.rb)
 * [Documentation](https://developer.frontdeskhq.com/docs/api/v2#endpoint-person)



## Registering clients for a class

Once a client has selected an event occurrence they wish to register for and you have found (or created)
a client profile for them in Front Desk, you can create a visit. This will add them to the class roster.

 * [Example code](lib/visit.rb)
 * [Documentation](https://developer.frontdeskhq.com/docs/api/v2#endpoint-visit)



## Paying for a visit with a pack

After a visit has been created, you may wish to mark it as paid by creating a pack and a punch.  If
your system is responsible for collecting payment, you will typically do this immediately after
creating the visit.  If not, you may want to skip this step entirely.

 * [Example code](lib/pack_and_punch.rb)
 * [Pack Documentation](https://developer.frontdeskhq.com/docs/api/v2?preview=true#endpoint-pack)
 * [Punch Documentation](https://developer.frontdeskhq.com/docs/api/v2#endpoint-punch)



## Deleting a visit (and optionally the pack that paid for it)

If a person cancels a visit in your system you will need to delete that visit in Front Desk.
If you orgininally created a single-use pack to pay for the visit, you will likely want to
delete that pack as well.  Deleting the visit or the pack will also delete the punch.

 * [Example code](lib/cancel.rb)
 * [Visit Documentation](https://developer.frontdeskhq.com/docs/api/v2#endpoint-visit)
 * [Pack Documentation](https://developer.frontdeskhq.com/docs/api/v2?preview=true#endpoint-pack)



## Marking a visit as late canceled

If you wish to enforce a late cancel policy in your application, you can reflect late cancels
in Front Desk by applying the "late_cancel" transition to a visit.

 * [Example code](lib/late_cancel.rb)
 * [Visit Documentation](https://developer.frontdeskhq.com/docs/api/v2#endpoint-visit)

