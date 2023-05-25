import 'package:app_pfe/models/reclamation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class ReclamationWidget extends StatelessWidget {
  final Reclamation reclamation;
  const ReclamationWidget({Key? key, required this.reclamation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.black.withOpacity(0.1)), bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
        ),
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            children: [
              SlidableAction(
                onPressed: (ctx) {},
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: UniconsLine.cancel,
                label: 'Annuler',
              ),
              SlidableAction(
                onPressed: (ctx) {},
                backgroundColor: Colors.red.withOpacity(0.7),
                foregroundColor: Colors.white,
                icon: UniconsLine.ticket,
                label: 'Terminer',
              ),
            ],
          ),
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        UniconsLine.comment,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('#${reclamation.id}'),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(overflow: TextOverflow.ellipsis, '${reclamation.subject}'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(DateFormat('dd MMM HH:mm').format(reclamation.date!)),
                                    Icon(
                                      UniconsLine.clock,
                                      color: Colors.red.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                UniconsLine.headphones,
                                color: Colors.red.withOpacity(0.3),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Tlili'),
                              ),
                              Row(
                                children: [
                                  Text(reclamation.status!),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
