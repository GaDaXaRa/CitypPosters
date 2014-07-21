//
//  CYPEventActionsManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 21/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPEventActionsManager.h"
#import "CYPCalendarHelper.h"
#import "CYPAlertViewHelper.h"
#import "CYPImagePersistence.h"
#import "CYPVenue+Model.h"

@interface CYPEventActionsManager ()

@property (strong, nonatomic) IBOutlet CYPCalendarHelper *calendarHelper;

@end

@implementation CYPEventActionsManager

- (void)saveEventImageToPhotoRoll:(CYPEvent *)event {
    UIImageWriteToSavedPhotosAlbum([CYPImagePersistence imageWithFileName:event.eventId], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)shareEvent:(CYPEvent *)event inController:(UIViewController *)controller {
    NSString *string = [event.name stringByAppendingString:[NSString stringWithFormat:@" con %@", [[[event.mainArtists allObjects] firstObject] name]]];
    UIImage *image = [CYPImagePersistence imageWithFileName:event.eventId];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[string, image] applicationActivities:nil];
    [controller presentViewController:activityViewController
                       animated:YES
                     completion:nil];
}

- (void)saveEventToCalendar:(CYPEvent *)event {
    [self.calendarHelper requestAccessWithCompletion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSString *locationString = event.venue.name;
            if (event.venue.address) {
                locationString = [locationString stringByAppendingString:[NSString stringWithFormat:@", %@", event.venue.address]];
            }
            NSDate *eventDate = [[[event.dates allObjects] firstObject] date];
            BOOL result = [self.calendarHelper addEventAt:eventDate  withTitle:event.name inLocation:locationString];
            
            if (!result) {
                [CYPAlertViewHelper showSimpleAlertViewWithTitle:@"Error al guardar en el calendario" andMessage:@"Ha ocurrido un error inesperado al guardar el evento en tu calendario"];
            } else {
                [CYPAlertViewHelper showSimpleAlertViewWithTitle:@"Evento añadido correctamente" andMessage:[NSString stringWithFormat:@"Se ha añadido el evento %@ a tu calendario", event.name]];
            }
        } else {
            [CYPAlertViewHelper showSimpleAlertViewWithTitle:@"Citypposters no tiene acceso a ti calendario" andMessage:@"Revisa los permisos para acceder a tu calendario en los ajustes del sistema"];
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo {
    if (error) {
        [CYPAlertViewHelper showSimpleAlertViewWithTitle:@"Error guardando la imagen" andMessage:@"Ha ocurrido un error inesperado mientras se guardaba la imagen del evento"];
    } else {
        [CYPAlertViewHelper showSimpleAlertViewWithTitle:@"Imagen guardada!" andMessage:@"El cartel se ha guardado correctamente en tu carpeta de imágenes"];
    }
}

@end
