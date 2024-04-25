import 'package:digital_escape_room/gen/assets.gen.dart';
import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:digital_escape_room/player_creation_form/player_creation_form.dart';
import 'package:digital_escape_room/player_selection/player_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nes_ui/nes_ui.dart';

class PlayerCreationForm extends StatelessWidget {
  const PlayerCreationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayerCreationFormBloc(),
      child: const PlayerCreation(),
    );
  }
}

class PlayerCreation extends StatelessWidget {
  const PlayerCreation({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: SizedBox(
            width: 700,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.welcomeToEscapeRoom,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                NesWindow(
                  icon: NesIcons.user,
                  title: l10n.gameDisclaimerTitle,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(l10n.gameDisclaimer),
                  ),
                ),
                const SizedBox(height: 20),
                NesContainer(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Assets.images.characters.conferenceWoman.path,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(l10n.name),
                                  ),
                                  onChanged: (name) => context
                                      .read<PlayerCreationFormBloc>()
                                      .add(NameChanged(name)),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(l10n.company),
                                  ),
                                  onChanged: (company) => context
                                      .read<PlayerCreationFormBloc>()
                                      .add(CompanyChanged(company)),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(l10n.jobTitle),
                                  ),
                                  onChanged: (jobTitle) => context
                                      .read<PlayerCreationFormBloc>()
                                      .add(JobTitleChanged(jobTitle)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AreasOfInterest(
                        onChange: (areasOfInterest) => context
                            .read<PlayerCreationFormBloc>()
                            .add(AreasOfInterestChanged(areasOfInterest)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<PlayerCreationFormBloc, PlayerCreationFormState>(
                  builder: (context, state) {
                    return NesButton(
                      type: NesButtonType.success,
                      onPressed: state.status.isSuccess
                          ? () {
                              context.read<PlayerSelectionBloc>().add(
                                    EnterEscapeRoomPressed(
                                      name: state.name.value,
                                      company: state.company.value,
                                      jobTitle: state.jobTitle.value,
                                      areasOfInterest:
                                          state.areasOfInterest.value,
                                    ),
                                  );
                            }
                          : null,
                      child: Text(context.l10n.enterEscapeRoom),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
